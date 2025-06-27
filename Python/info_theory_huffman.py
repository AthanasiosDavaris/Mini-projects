import heapq
from collections import defaultdict
import graphviz
from graphviz import ExecutableNotFound, Digraph

class HuffmanNode:
  def __init__(self, prob, symbol=None, left=None, right=None):
    self.prob = prob
    self.symbol = symbol
    self.left = left
    self.right = right

  def __lt__(self, other):
    return self.prob < other.prob

def huffman_tree_build(probs):
  heap = []
  symbol_id = 0
  for prob in probs:
    heapq.heappush(heap, HuffmanNode(prob, symbol=f"S{symbol_id}"))
    symbol_id += 1

  while len(heap) > 1:
    left = heapq.heappop(heap)
    right = heapq.heappop(heap)
    merged = HuffmanNode(left.prob + right.prob, left=left, right=right)
    heapq.heappush(heap, merged)
  
  return heapq.heappop(heap)

def code_gen(node, prefix="", codebook={}):
  if node.symbol:
    codebook[node.symbol] = prefix
  else:
    code_gen(node.left, prefix + "0", codebook)
    code_gen(node.right, prefix + "1", codebook)
  return codebook

def plot_tree(node, graph=None, parent=None, label=""):
  if graph is None:
    graph = Digraph()
    graph.node(name=str(id(node)), label=f"{node.prob:.4f}\n{node.symbol or ''}")

  if parent is not None:
    graph.edge(str(id(parent)), str(id(node)), label=label)

  if node.left:
    graph.node(name=str(id(node.left)), label=f"{node.left.prob:.4f}\n{node.left.symbol or ''}")
    plot_tree(node.left, graph, node, "0")

    if node.right:
      graph.node(name=str(id(node.right)), label=f"{node.right.prob:.4f}\n{node.left.symbol or ''}")
      plot_tree(node.right, graph, node, "1")
    
    return graph

probs = [0.5, 0.125, 0.125, 0.0625, 0.0625, 0.0625, 0.0625]
symbols = [f"S{i}" for i in range(len(probs))]

root = huffman_tree_build(probs)
huffman_codes = code_gen(root)

print("Huffman Codes:")
for symbol, code in sorted(huffman_codes.items()):
  print(f"{symbol}: {code}")

average_length = sum(prob * len(huffman_codes[symbol]) for prob, symbol in zip(probs, symbols))
print(f"\nThe Average Code length is {average_length:.2f} bits/symbol")

try:
  tree_graph = plot_tree(root)
  tree_graph.render('huffman_tree', format='png', cleanup=True)
except ExecutableNotFound:
  print("Graphviz not in PATH. Using temporary workaround...")
  graphviz.set_jupyter_format('png')
  graphviz.backend.execute.DOT_BINARY = 'C:/Users/Thanos from avengers/AppData/Local/Programs/Python/Python312/Lib/site-packages/graphviz/dot'
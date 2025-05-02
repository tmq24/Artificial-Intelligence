from heapq import heappush, heappop

def UCS(graph, start, goal):
    # Use heapq instead of PriorityQueue because it is faster
    frontier = [(0, start)]  
    explored = set()
    parent = {start: None}
    cost = {start: 0}
    
    while frontier:
        current_cost, current = heappop(frontier)
        
        if current == goal:  # Found the goal
            break
            
        if current in explored:  # Skip if already visited
            continue
            
        explored.add(current)
        
        # Traverse neighbors with non-zero weights
        for next_vertex, weight in enumerate(graph[current]):
            if weight > 0:  # Only consider edges with weight > 0
                new_cost = current_cost + weight
                
                # Update if a better path is found or the vertex is unvisited
                if next_vertex not in cost or new_cost < cost[next_vertex]:
                    cost[next_vertex] = new_cost
                    heappush(frontier, (new_cost, next_vertex))
                    parent[next_vertex] = current

    # Trace the path
    if goal not in parent:  # Check if there is a path to the goal
        return None, float('inf')
        
    path = []
    current = goal
    while current is not None:
        path.append(current)
        current = parent[current]
    
    return path[::-1], cost[goal]  # Reverse path to get the correct order

def read_input(filename):
    with open(filename, 'r') as f:
        n = int(f.readline())
        start, goal = map(int, f.readline().split())
        graph = [list(map(int, f.readline().split())) for _ in range(n)]
    return n, start, goal, graph

def main():
    # Read input
    n, start, goal, graph = read_input('InputUCS.txt')
    
    # Find the path
    path, total_cost = UCS(graph, start, goal)
    
    # Print the result
    if path:
        print(f"Shortest path cost: {total_cost}")
        print(f"Path: {' -> '.join(map(str, path))}")
    else:
        print("No path found to the goal!")

if __name__ == "__main__":
    main()
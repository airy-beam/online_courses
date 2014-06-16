/* 
 * File:   main.cpp
 * Author: ouwater
 *
 * Created on 16 Апрель 2012 г., 20:49
 */

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;
const int NUMBER_OF_VERTICES = 875714;
vector <vector<int> > direct_edges(NUMBER_OF_VERTICES + 1);
vector <vector<int> > reverse_edges(NUMBER_OF_VERTICES + 1);
int f[NUMBER_OF_VERTICES + 1];
int order_of_f[NUMBER_OF_VERTICES + 1];
int leader[NUMBER_OF_VERTICES + 1];
bool explored[ NUMBER_OF_VERTICES + 1 ];
int s, t;
bool first_call;

void dfs(vector <vector<int> > &g, int i)
{
    explored[ i ] = true;
    leader[ i ] = s;

    for ( int k = 0; k < g[ i ].size(); k++ )
        if ( ! ( explored[ (g[ i ])[ k ] ] ) )
        {
            explored[ (g[ i ])[ k ] ] = true;
            dfs( g, (g[ i ])[ k ] );
        }
    
    if ( first_call)
    {
        t++;
        f[ i ] = t;
        order_of_f[ f[ i ] ] = i;
    }
}

void dfs_loop(vector <vector<int> > &g)
{
    t = 0;
    s = 0;
    for (int i = NUMBER_OF_VERTICES; i >= 1; i-- ) explored[ i ] = false;
        if (first_call)
        {
            for (int vertex = NUMBER_OF_VERTICES; vertex >= 1; vertex-- )
                if ( ! (explored[ vertex ] ) )
                {
                    s = vertex;
                    dfs( g, vertex );
                }
        }
        else
        {
            for (int vertex = NUMBER_OF_VERTICES; vertex >= 1; vertex-- )
                if ( ! (explored[ order_of_f[ vertex ] ] ) )
                {
                    s = order_of_f[ vertex ];
                    dfs( g, order_of_f[ vertex ] );
                }
        }
}
  
int main(int argc, char** argv) {
    ifstream fgraph;
    fgraph.open("SCC.txt");
    int edge_from, edge_to;
    int count_edges = 0;
    while ( fgraph >> edge_from >> edge_to )
    {
        (direct_edges[edge_from]).push_back(edge_to);
        (reverse_edges[edge_to]).push_back(edge_from);
        count_edges++;
    }

    first_call = true;
    dfs_loop(reverse_edges);
    
    first_call = false;
    dfs_loop(direct_edges);

    std::map<int, int> scc;
    map<int,int>::iterator scc_it;
    vector<int> scc_sizes;
    vector<int>::iterator scc_sizes_it;

    for (int i = 1; i <= NUMBER_OF_VERTICES; i++ )
        ++scc[ leader[ i ] ];

    for ( scc_it=scc.begin() ; scc_it != scc.end(); scc_it++ )
        scc_sizes.push_back((*scc_it).second);
    sort(scc_sizes.rbegin(), scc_sizes.rend());
    
    for (scc_sizes_it = scc_sizes.begin(); scc_sizes_it != scc_sizes.begin() + 5; ++scc_sizes_it)
        std::cout << *scc_sizes_it << ",";
    std::cout << std::endl;
    
    return 0;
}


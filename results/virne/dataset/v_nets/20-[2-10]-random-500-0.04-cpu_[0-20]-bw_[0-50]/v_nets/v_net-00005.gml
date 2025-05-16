graph [
  node_attrs_setting "_networkx_list_start"
  node_attrs_setting [
    name "cpu"
    type "resource"
    owner "node"
    distribution "uniform"
    dtype "int"
    generative "True"
    low "0"
    high "20"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    type "resource"
    owner "link"
    distribution "uniform"
    dtype "int"
    generative "True"
    low "0"
    high "50"
  ]
  id 5
  arrival_time 136.0
  lifetime 75.61542857136058
  num_nodes 5
  type "random"
  node [
    id 0
    label "0"
    cpu 18
  ]
  node [
    id 1
    label "1"
    cpu 8
  ]
  node [
    id 2
    label "2"
    cpu 15
  ]
  node [
    id 3
    label "3"
    cpu 11
  ]
  node [
    id 4
    label "4"
    cpu 6
  ]
  edge [
    source 0
    target 2
    bw 47
  ]
  edge [
    source 0
    target 4
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 1
    target 4
    bw 31
  ]
  edge [
    source 2
    target 4
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
]

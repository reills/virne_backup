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
  id 7
  arrival_time 194.0
  lifetime 1750.1068281010932
  num_nodes 4
  type "random"
  node [
    id 0
    label "0"
    cpu 4
  ]
  node [
    id 1
    label "1"
    cpu 4
  ]
  node [
    id 2
    label "2"
    cpu 12
  ]
  node [
    id 3
    label "3"
    cpu 17
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 0
    target 2
    bw 30
  ]
  edge [
    source 0
    target 3
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 1
    target 3
    bw 33
  ]
]

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
  id 36
  arrival_time 896.0
  lifetime 28.663463625500732
  num_nodes 3
  type "random"
  node [
    id 0
    label "0"
    cpu 8
  ]
  node [
    id 1
    label "1"
    cpu 0
  ]
  node [
    id 2
    label "2"
    cpu 17
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 0
    target 2
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
]

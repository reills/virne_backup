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
  id 13
  arrival_time 347.0
  lifetime 385.41733054957973
  num_nodes 3
  type "random"
  node [
    id 0
    label "0"
    cpu 17
  ]
  node [
    id 1
    label "1"
    cpu 19
  ]
  node [
    id 2
    label "2"
    cpu 3
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 0
    target 2
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
]

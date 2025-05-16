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
  id 49
  arrival_time 1223.0
  lifetime 355.62396831078695
  num_nodes 8
  type "random"
  node [
    id 0
    label "0"
    cpu 0
  ]
  node [
    id 1
    label "1"
    cpu 9
  ]
  node [
    id 2
    label "2"
    cpu 8
  ]
  node [
    id 3
    label "3"
    cpu 18
  ]
  node [
    id 4
    label "4"
    cpu 11
  ]
  node [
    id 5
    label "5"
    cpu 19
  ]
  node [
    id 6
    label "6"
    cpu 17
  ]
  node [
    id 7
    label "7"
    cpu 15
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 0
    target 3
    bw 42
  ]
  edge [
    source 1
    target 3
    bw 24
  ]
  edge [
    source 1
    target 6
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 2
    target 7
    bw 21
  ]
  edge [
    source 3
    target 5
    bw 14
  ]
  edge [
    source 4
    target 6
    bw 47
  ]
  edge [
    source 4
    target 7
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 5
    target 7
    bw 11
  ]
]

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
  id 39
  arrival_time 973.0
  lifetime 291.4391942353519
  num_nodes 9
  type "random"
  node [
    id 0
    label "0"
    cpu 1
  ]
  node [
    id 1
    label "1"
    cpu 14
  ]
  node [
    id 2
    label "2"
    cpu 5
  ]
  node [
    id 3
    label "3"
    cpu 16
  ]
  node [
    id 4
    label "4"
    cpu 3
  ]
  node [
    id 5
    label "5"
    cpu 7
  ]
  node [
    id 6
    label "6"
    cpu 1
  ]
  node [
    id 7
    label "7"
    cpu 8
  ]
  node [
    id 8
    label "8"
    cpu 0
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 0
    target 2
    bw 37
  ]
  edge [
    source 0
    target 3
    bw 47
  ]
  edge [
    source 0
    target 5
    bw 26
  ]
  edge [
    source 0
    target 7
    bw 25
  ]
  edge [
    source 0
    target 8
    bw 25
  ]
  edge [
    source 1
    target 7
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 2
    target 5
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 3
    target 6
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 4
    target 7
    bw 16
  ]
  edge [
    source 4
    target 8
    bw 48
  ]
  edge [
    source 5
    target 8
    bw 43
  ]
  edge [
    source 6
    target 8
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
]

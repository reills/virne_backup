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
  id 14
  arrival_time 377.0
  lifetime 19.591578695075956
  num_nodes 8
  type "random"
  node [
    id 0
    label "0"
    cpu 15
  ]
  node [
    id 1
    label "1"
    cpu 8
  ]
  node [
    id 2
    label "2"
    cpu 0
  ]
  node [
    id 3
    label "3"
    cpu 10
  ]
  node [
    id 4
    label "4"
    cpu 11
  ]
  node [
    id 5
    label "5"
    cpu 13
  ]
  node [
    id 6
    label "6"
    cpu 7
  ]
  node [
    id 7
    label "7"
    cpu 6
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 0
    target 3
    bw 30
  ]
  edge [
    source 0
    target 6
    bw 15
  ]
  edge [
    source 0
    target 7
    bw 41
  ]
  edge [
    source 1
    target 4
    bw 38
  ]
  edge [
    source 1
    target 6
    bw 43
  ]
  edge [
    source 1
    target 7
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 2
    target 5
    bw 28
  ]
  edge [
    source 2
    target 7
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 4
    target 6
    bw 50
  ]
  edge [
    source 4
    target 7
    bw 28
  ]
]

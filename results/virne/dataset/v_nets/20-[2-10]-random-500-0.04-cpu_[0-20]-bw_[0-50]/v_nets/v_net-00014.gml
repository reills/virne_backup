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
  arrival_time 372.0
  lifetime 710.6823481005537
  num_nodes 8
  type "random"
  node [
    id 0
    label "0"
    cpu 19
  ]
  node [
    id 1
    label "1"
    cpu 11
  ]
  node [
    id 2
    label "2"
    cpu 18
  ]
  node [
    id 3
    label "3"
    cpu 13
  ]
  node [
    id 4
    label "4"
    cpu 1
  ]
  node [
    id 5
    label "5"
    cpu 6
  ]
  node [
    id 6
    label "6"
    cpu 10
  ]
  node [
    id 7
    label "7"
    cpu 16
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 0
    target 3
    bw 16
  ]
  edge [
    source 0
    target 6
    bw 26
  ]
  edge [
    source 0
    target 7
    bw 35
  ]
  edge [
    source 1
    target 4
    bw 49
  ]
  edge [
    source 1
    target 6
    bw 42
  ]
  edge [
    source 1
    target 7
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 2
    target 5
    bw 13
  ]
  edge [
    source 2
    target 7
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 4
    target 6
    bw 8
  ]
  edge [
    source 4
    target 7
    bw 13
  ]
]

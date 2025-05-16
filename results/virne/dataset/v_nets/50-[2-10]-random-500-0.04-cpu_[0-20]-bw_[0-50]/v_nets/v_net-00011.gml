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
  id 11
  arrival_time 305.0
  lifetime 694.5213496086875
  num_nodes 10
  type "random"
  node [
    id 0
    label "0"
    cpu 7
  ]
  node [
    id 1
    label "1"
    cpu 8
  ]
  node [
    id 2
    label "2"
    cpu 20
  ]
  node [
    id 3
    label "3"
    cpu 7
  ]
  node [
    id 4
    label "4"
    cpu 3
  ]
  node [
    id 5
    label "5"
    cpu 12
  ]
  node [
    id 6
    label "6"
    cpu 3
  ]
  node [
    id 7
    label "7"
    cpu 6
  ]
  node [
    id 8
    label "8"
    cpu 20
  ]
  node [
    id 9
    label "9"
    cpu 7
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 0
    target 3
    bw 31
  ]
  edge [
    source 0
    target 4
    bw 0
  ]
  edge [
    source 0
    target 5
    bw 5
  ]
  edge [
    source 1
    target 3
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 2
    target 5
    bw 30
  ]
  edge [
    source 2
    target 7
    bw 9
  ]
  edge [
    source 2
    target 8
    bw 19
  ]
  edge [
    source 2
    target 9
    bw 7
  ]
  edge [
    source 3
    target 6
    bw 21
  ]
  edge [
    source 3
    target 8
    bw 37
  ]
  edge [
    source 3
    target 9
    bw 28
  ]
  edge [
    source 4
    target 6
    bw 8
  ]
  edge [
    source 4
    target 7
    bw 43
  ]
  edge [
    source 4
    target 9
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 5
    target 7
    bw 40
  ]
  edge [
    source 5
    target 8
    bw 38
  ]
  edge [
    source 5
    target 9
    bw 25
  ]
  edge [
    source 6
    target 8
    bw 10
  ]
  edge [
    source 6
    target 9
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 7
    target 9
    bw 32
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
]

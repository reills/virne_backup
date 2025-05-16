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
  id 12
  arrival_time 320.0
  lifetime 436.1605985201903
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
    cpu 13
  ]
  node [
    id 2
    label "2"
    cpu 17
  ]
  node [
    id 3
    label "3"
    cpu 20
  ]
  node [
    id 4
    label "4"
    cpu 0
  ]
  node [
    id 5
    label "5"
    cpu 11
  ]
  node [
    id 6
    label "6"
    cpu 4
  ]
  node [
    id 7
    label "7"
    cpu 0
  ]
  node [
    id 8
    label "8"
    cpu 10
  ]
  node [
    id 9
    label "9"
    cpu 14
  ]
  edge [
    source 0
    target 2
    bw 22
  ]
  edge [
    source 0
    target 5
    bw 28
  ]
  edge [
    source 0
    target 6
    bw 20
  ]
  edge [
    source 0
    target 8
    bw 18
  ]
  edge [
    source 0
    target 9
    bw 4
  ]
  edge [
    source 1
    target 6
    bw 22
  ]
  edge [
    source 1
    target 9
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 19
  ]
  edge [
    source 2
    target 5
    bw 7
  ]
  edge [
    source 2
    target 6
    bw 8
  ]
  edge [
    source 2
    target 7
    bw 13
  ]
  edge [
    source 2
    target 9
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 3
    target 7
    bw 8
  ]
  edge [
    source 3
    target 8
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 15
  ]
  edge [
    source 4
    target 7
    bw 11
  ]
  edge [
    source 4
    target 8
    bw 4
  ]
  edge [
    source 4
    target 9
    bw 39
  ]
  edge [
    source 5
    target 9
    bw 28
  ]
  edge [
    source 6
    target 8
    bw 45
  ]
  edge [
    source 6
    target 9
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 7
    target 9
    bw 46
  ]
]

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
  id 9
  arrival_time 238.0
  lifetime 367.4822096182083
  num_nodes 9
  type "random"
  node [
    id 0
    label "0"
    cpu 12
  ]
  node [
    id 1
    label "1"
    cpu 3
  ]
  node [
    id 2
    label "2"
    cpu 9
  ]
  node [
    id 3
    label "3"
    cpu 10
  ]
  node [
    id 4
    label "4"
    cpu 13
  ]
  node [
    id 5
    label "5"
    cpu 7
  ]
  node [
    id 6
    label "6"
    cpu 7
  ]
  node [
    id 7
    label "7"
    cpu 1
  ]
  node [
    id 8
    label "8"
    cpu 12
  ]
  edge [
    source 0
    target 3
    bw 34
  ]
  edge [
    source 0
    target 4
    bw 34
  ]
  edge [
    source 0
    target 6
    bw 24
  ]
  edge [
    source 0
    target 7
    bw 33
  ]
  edge [
    source 0
    target 8
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 1
    target 5
    bw 36
  ]
  edge [
    source 1
    target 6
    bw 0
  ]
  edge [
    source 1
    target 8
    bw 11
  ]
  edge [
    source 2
    target 4
    bw 34
  ]
  edge [
    source 2
    target 6
    bw 5
  ]
  edge [
    source 2
    target 7
    bw 16
  ]
  edge [
    source 2
    target 8
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 3
    target 6
    bw 17
  ]
  edge [
    source 3
    target 7
    bw 48
  ]
  edge [
    source 3
    target 8
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 5
    target 7
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 6
    target 8
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
]

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
  arrival_time 293.0
  lifetime 637.6138567280224
  num_nodes 10
  type "random"
  node [
    id 0
    label "0"
    cpu 17
  ]
  node [
    id 1
    label "1"
    cpu 6
  ]
  node [
    id 2
    label "2"
    cpu 7
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
    cpu 9
  ]
  node [
    id 8
    label "8"
    cpu 14
  ]
  node [
    id 9
    label "9"
    cpu 9
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 0
    target 3
    bw 50
  ]
  edge [
    source 0
    target 4
    bw 32
  ]
  edge [
    source 0
    target 5
    bw 27
  ]
  edge [
    source 1
    target 3
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 2
    target 5
    bw 43
  ]
  edge [
    source 2
    target 7
    bw 17
  ]
  edge [
    source 2
    target 8
    bw 41
  ]
  edge [
    source 2
    target 9
    bw 0
  ]
  edge [
    source 3
    target 6
    bw 22
  ]
  edge [
    source 3
    target 8
    bw 16
  ]
  edge [
    source 3
    target 9
    bw 42
  ]
  edge [
    source 4
    target 6
    bw 36
  ]
  edge [
    source 4
    target 7
    bw 30
  ]
  edge [
    source 4
    target 9
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 5
    target 7
    bw 8
  ]
  edge [
    source 5
    target 8
    bw 27
  ]
  edge [
    source 5
    target 9
    bw 29
  ]
  edge [
    source 6
    target 8
    bw 46
  ]
  edge [
    source 6
    target 9
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 32
  ]
  edge [
    source 7
    target 9
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
]

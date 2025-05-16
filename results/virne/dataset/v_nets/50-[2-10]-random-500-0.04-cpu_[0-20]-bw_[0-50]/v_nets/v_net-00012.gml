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
  arrival_time 329.0
  lifetime 468.0307824501104
  num_nodes 10
  type "random"
  node [
    id 0
    label "0"
    cpu 14
  ]
  node [
    id 1
    label "1"
    cpu 0
  ]
  node [
    id 2
    label "2"
    cpu 19
  ]
  node [
    id 3
    label "3"
    cpu 6
  ]
  node [
    id 4
    label "4"
    cpu 1
  ]
  node [
    id 5
    label "5"
    cpu 12
  ]
  node [
    id 6
    label "6"
    cpu 18
  ]
  node [
    id 7
    label "7"
    cpu 13
  ]
  node [
    id 8
    label "8"
    cpu 9
  ]
  node [
    id 9
    label "9"
    cpu 4
  ]
  edge [
    source 0
    target 2
    bw 29
  ]
  edge [
    source 0
    target 5
    bw 27
  ]
  edge [
    source 0
    target 6
    bw 17
  ]
  edge [
    source 0
    target 8
    bw 35
  ]
  edge [
    source 0
    target 9
    bw 2
  ]
  edge [
    source 1
    target 6
    bw 20
  ]
  edge [
    source 1
    target 9
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 2
    target 5
    bw 36
  ]
  edge [
    source 2
    target 6
    bw 41
  ]
  edge [
    source 2
    target 7
    bw 4
  ]
  edge [
    source 2
    target 9
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 3
    target 7
    bw 13
  ]
  edge [
    source 3
    target 8
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 4
    target 7
    bw 23
  ]
  edge [
    source 4
    target 8
    bw 34
  ]
  edge [
    source 4
    target 9
    bw 35
  ]
  edge [
    source 5
    target 9
    bw 9
  ]
  edge [
    source 6
    target 8
    bw 26
  ]
  edge [
    source 6
    target 9
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 7
    target 9
    bw 12
  ]
]

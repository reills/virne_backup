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
  id 29
  arrival_time 723.0
  lifetime 543.1346888080848
  num_nodes 10
  type "random"
  node [
    id 0
    label "0"
    cpu 19
  ]
  node [
    id 1
    label "1"
    cpu 8
  ]
  node [
    id 2
    label "2"
    cpu 5
  ]
  node [
    id 3
    label "3"
    cpu 20
  ]
  node [
    id 4
    label "4"
    cpu 11
  ]
  node [
    id 5
    label "5"
    cpu 1
  ]
  node [
    id 6
    label "6"
    cpu 11
  ]
  node [
    id 7
    label "7"
    cpu 15
  ]
  node [
    id 8
    label "8"
    cpu 12
  ]
  node [
    id 9
    label "9"
    cpu 15
  ]
  edge [
    source 0
    target 3
    bw 12
  ]
  edge [
    source 0
    target 4
    bw 21
  ]
  edge [
    source 0
    target 6
    bw 18
  ]
  edge [
    source 0
    target 8
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 1
    target 4
    bw 30
  ]
  edge [
    source 1
    target 5
    bw 28
  ]
  edge [
    source 1
    target 6
    bw 44
  ]
  edge [
    source 1
    target 7
    bw 41
  ]
  edge [
    source 1
    target 9
    bw 21
  ]
  edge [
    source 2
    target 4
    bw 6
  ]
  edge [
    source 2
    target 5
    bw 36
  ]
  edge [
    source 2
    target 7
    bw 48
  ]
  edge [
    source 2
    target 9
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 3
    target 6
    bw 30
  ]
  edge [
    source 3
    target 8
    bw 5
  ]
  edge [
    source 4
    target 8
    bw 15
  ]
  edge [
    source 4
    target 9
    bw 37
  ]
  edge [
    source 6
    target 8
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 7
    target 9
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
]

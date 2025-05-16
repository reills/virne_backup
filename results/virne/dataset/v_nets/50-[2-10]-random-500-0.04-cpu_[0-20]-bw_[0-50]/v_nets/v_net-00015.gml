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
  id 15
  arrival_time 398.0
  lifetime 502.93550914942807
  num_nodes 9
  type "random"
  node [
    id 0
    label "0"
    cpu 14
  ]
  node [
    id 1
    label "1"
    cpu 5
  ]
  node [
    id 2
    label "2"
    cpu 4
  ]
  node [
    id 3
    label "3"
    cpu 18
  ]
  node [
    id 4
    label "4"
    cpu 14
  ]
  node [
    id 5
    label "5"
    cpu 18
  ]
  node [
    id 6
    label "6"
    cpu 1
  ]
  node [
    id 7
    label "7"
    cpu 12
  ]
  node [
    id 8
    label "8"
    cpu 0
  ]
  edge [
    source 0
    target 3
    bw 41
  ]
  edge [
    source 0
    target 4
    bw 16
  ]
  edge [
    source 0
    target 6
    bw 2
  ]
  edge [
    source 0
    target 7
    bw 8
  ]
  edge [
    source 0
    target 8
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 1
    target 4
    bw 26
  ]
  edge [
    source 1
    target 5
    bw 27
  ]
  edge [
    source 1
    target 6
    bw 1
  ]
  edge [
    source 3
    target 8
    bw 0
  ]
  edge [
    source 4
    target 8
    bw 5
  ]
  edge [
    source 5
    target 7
    bw 24
  ]
]

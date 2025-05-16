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
  id 10
  arrival_time 287.0
  lifetime 221.70201179382775
  num_nodes 8
  type "random"
  node [
    id 0
    label "0"
    cpu 12
  ]
  node [
    id 1
    label "1"
    cpu 4
  ]
  node [
    id 2
    label "2"
    cpu 1
  ]
  node [
    id 3
    label "3"
    cpu 17
  ]
  node [
    id 4
    label "4"
    cpu 0
  ]
  node [
    id 5
    label "5"
    cpu 7
  ]
  node [
    id 6
    label "6"
    cpu 4
  ]
  node [
    id 7
    label "7"
    cpu 3
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 0
    target 4
    bw 6
  ]
  edge [
    source 0
    target 6
    bw 3
  ]
  edge [
    source 0
    target 7
    bw 34
  ]
  edge [
    source 1
    target 3
    bw 40
  ]
  edge [
    source 1
    target 6
    bw 33
  ]
  edge [
    source 1
    target 7
    bw 28
  ]
  edge [
    source 2
    target 5
    bw 4
  ]
  edge [
    source 2
    target 7
    bw 26
  ]
  edge [
    source 3
    target 5
    bw 32
  ]
  edge [
    source 3
    target 6
    bw 45
  ]
  edge [
    source 3
    target 7
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
]

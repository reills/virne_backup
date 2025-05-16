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
  id 48
  arrival_time 1190.0
  lifetime 1001.6202513226889
  num_nodes 7
  type "random"
  node [
    id 0
    label "0"
    cpu 11
  ]
  node [
    id 1
    label "1"
    cpu 14
  ]
  node [
    id 2
    label "2"
    cpu 18
  ]
  node [
    id 3
    label "3"
    cpu 12
  ]
  node [
    id 4
    label "4"
    cpu 3
  ]
  node [
    id 5
    label "5"
    cpu 5
  ]
  node [
    id 6
    label "6"
    cpu 7
  ]
  edge [
    source 0
    target 3
    bw 29
  ]
  edge [
    source 0
    target 5
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 1
    target 3
    bw 9
  ]
  edge [
    source 1
    target 4
    bw 11
  ]
  edge [
    source 1
    target 6
    bw 16
  ]
  edge [
    source 2
    target 6
    bw 39
  ]
  edge [
    source 3
    target 5
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
]

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
  id 8
  arrival_time 214.0
  lifetime 807.0010361407591
  num_nodes 6
  type "random"
  node [
    id 0
    label "0"
    cpu 19
  ]
  node [
    id 1
    label "1"
    cpu 14
  ]
  node [
    id 2
    label "2"
    cpu 20
  ]
  node [
    id 3
    label "3"
    cpu 3
  ]
  node [
    id 4
    label "4"
    cpu 3
  ]
  node [
    id 5
    label "5"
    cpu 7
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 0
    target 2
    bw 9
  ]
  edge [
    source 0
    target 4
    bw 41
  ]
  edge [
    source 0
    target 5
    bw 23
  ]
  edge [
    source 1
    target 3
    bw 3
  ]
  edge [
    source 1
    target 4
    bw 46
  ]
  edge [
    source 2
    target 5
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
]

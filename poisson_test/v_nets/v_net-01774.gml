graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1774
  arrival_time 39461.78286590461
  lifetime 2606.418719409452
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 27
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 20
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 25
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 50
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 30
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 42
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 26
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 46
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 12
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
]

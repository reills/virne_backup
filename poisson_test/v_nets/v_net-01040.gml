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
  id 1040
  arrival_time 21950.308264743835
  lifetime 2428.0097330168314
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 5
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 43
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 46
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 36
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 39
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 22
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 24
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 1
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 27
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 35
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 18
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 14
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
]

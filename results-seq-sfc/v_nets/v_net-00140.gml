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
  id 140
  arrival_time 2395.0149404429253
  lifetime 520.2990982303651
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 19
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 12
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 11
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 50
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 8
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 31
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 19
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 49
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 25
    gpu 44
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 47
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 50
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
]

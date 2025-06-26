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
  id 442
  arrival_time 8485.499979876613
  lifetime 941.6864079129194
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 41
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 24
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 35
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 24
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 32
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 11
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 14
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 4
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 8
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 9
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 35
    gpu 1
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
]

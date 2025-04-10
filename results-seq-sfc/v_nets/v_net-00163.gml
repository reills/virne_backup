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
  id 163
  arrival_time 3091.2900309305974
  lifetime 926.0284238441144
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 16
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 28
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 3
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 2
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 27
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 12
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 44
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 40
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 33
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 24
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 18
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 6
    rom 37
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 10
    rom 23
  ]
  node [
    id 13
    label "13"
    cpu 36
    gpu 3
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 44
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
  edge [
    source 12
    target 13
    bw 43
  ]
]

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
  id 387
  arrival_time 7666.441311278226
  lifetime 643.6129496637543
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 22
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 11
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 49
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 26
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 46
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 10
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 15
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 21
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 44
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 8
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 5
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 17
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 29
    rom 30
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 6
  ]
  edge [
    source 11
    target 12
    bw 12
  ]
]

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
  id 1378
  arrival_time 29209.084024617285
  lifetime 928.558290405127
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 11
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 23
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 40
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 3
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 20
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 22
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 2
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 4
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 30
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 41
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 1
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 14
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 2
    gpu 46
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
]

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
  id 1368
  arrival_time 28911.97424882445
  lifetime 1945.3856104996246
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 15
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 28
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 23
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 2
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 20
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 23
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 2
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 12
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 23
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 25
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 41
    rom 27
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 14
    rom 42
  ]
  node [
    id 12
    label "12"
    cpu 23
    gpu 1
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 4
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

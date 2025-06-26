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
  id 1257
  arrival_time 26014.373404734382
  lifetime 735.8506463132788
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 26
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 36
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 27
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 14
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 22
    gpu 38
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 41
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 20
    gpu 29
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 15
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 20
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 16
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 24
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
]

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
  id 985
  arrival_time 20972.519350494564
  lifetime 244.73326304126644
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 44
    rom 29
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 36
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 30
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 26
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 28
    gpu 16
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 13
    rom 39
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 41
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 20
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 11
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 38
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 21
    gpu 22
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 20
    rom 34
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 44
    rom 22
  ]
  node [
    id 13
    label "13"
    cpu 30
    gpu 11
    rom 44
  ]
  node [
    id 14
    label "14"
    cpu 21
    gpu 0
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 40
  ]
  edge [
    source 11
    target 12
    bw 24
  ]
  edge [
    source 12
    target 13
    bw 31
  ]
  edge [
    source 13
    target 14
    bw 28
  ]
]

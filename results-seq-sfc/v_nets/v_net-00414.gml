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
  id 414
  arrival_time 8121.516304709976
  lifetime 113.08028702081586
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 1
    rom 13
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 48
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 8
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 22
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 24
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 12
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 50
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 2
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 41
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 32
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 36
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 38
    rom 35
  ]
  node [
    id 12
    label "12"
    cpu 5
    gpu 21
    rom 40
  ]
  node [
    id 13
    label "13"
    cpu 38
    gpu 28
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
  edge [
    source 10
    target 11
    bw 31
  ]
  edge [
    source 11
    target 12
    bw 16
  ]
  edge [
    source 12
    target 13
    bw 25
  ]
]

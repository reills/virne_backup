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
  id 1807
  arrival_time 40105.34853636345
  lifetime 248.99331014053203
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 11
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 31
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 28
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 12
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 10
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 27
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 21
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 36
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 34
    rom 25
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 9
    rom 16
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 1
    rom 23
  ]
  node [
    id 11
    label "11"
    cpu 21
    gpu 17
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 50
    rom 43
  ]
  node [
    id 13
    label "13"
    cpu 45
    gpu 21
    rom 45
  ]
  node [
    id 14
    label "14"
    cpu 23
    gpu 40
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
  edge [
    source 9
    target 10
    bw 50
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 36
  ]
  edge [
    source 12
    target 13
    bw 40
  ]
  edge [
    source 13
    target 14
    bw 29
  ]
]

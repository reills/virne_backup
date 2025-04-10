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
  id 1190
  arrival_time 24693.897453154706
  lifetime 53.58677142557722
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 12
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 21
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 38
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 9
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 29
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 10
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 36
    rom 11
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 36
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 17
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 28
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 40
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 18
    gpu 9
    rom 46
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 29
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
  edge [
    source 11
    target 12
    bw 14
  ]
]

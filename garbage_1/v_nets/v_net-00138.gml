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
  id 138
  arrival_time 2375.03257912564
  lifetime 394.6199561870768
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 6
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 2
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 44
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 17
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 9
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 31
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 15
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 33
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 44
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 43
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 33
    gpu 13
    rom 1
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 48
    rom 21
  ]
  node [
    id 12
    label "12"
    cpu 22
    gpu 6
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 1
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
  edge [
    source 10
    target 11
    bw 16
  ]
  edge [
    source 11
    target 12
    bw 19
  ]
]

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
  id 1095
  arrival_time 22851.51155964845
  lifetime 1614.5413512489533
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 41
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 48
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 5
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 0
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 42
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 46
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 10
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 36
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 10
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 40
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
]

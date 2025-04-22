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
  id 897
  arrival_time 19267.938160076097
  lifetime 580.2764418942244
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 34
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 1
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 49
    gpu 15
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 50
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 27
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 6
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 18
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 42
    rom 46
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 2
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 25
    rom 10
  ]
  node [
    id 10
    label "10"
    cpu 12
    gpu 18
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 27
    rom 43
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 40
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
  edge [
    source 9
    target 10
    bw 41
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 48
  ]
]

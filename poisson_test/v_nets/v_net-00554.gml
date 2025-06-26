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
  id 554
  arrival_time 10403.278846143414
  lifetime 823.5191623633392
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 11
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 0
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 14
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 20
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 1
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 15
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 17
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 7
    rom 6
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 23
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 48
    gpu 47
    rom 7
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
]

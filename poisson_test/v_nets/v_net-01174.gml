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
  id 1174
  arrival_time 24350.098542006665
  lifetime 4160.25085584208
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 22
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 42
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 45
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 17
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 35
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 1
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 40
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 12
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 8
    rom 23
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 11
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
]

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
  id 887
  arrival_time 18738.391974019956
  lifetime 4270.536624386437
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 26
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 18
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 13
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 28
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 16
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 10
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 22
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 19
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 12
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 5
    rom 3
  ]
  node [
    id 10
    label "10"
    cpu 40
    gpu 39
    rom 49
  ]
  node [
    id 11
    label "11"
    cpu 1
    gpu 22
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 28
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 43
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
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 44
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
]

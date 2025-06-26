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
  id 618
  arrival_time 12808.616799612022
  lifetime 2272.5706437065337
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 9
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 41
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 43
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 22
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 42
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 43
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 36
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 44
    rom 11
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 31
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 40
    rom 31
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 37
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 32
    gpu 39
    rom 38
  ]
  node [
    id 12
    label "12"
    cpu 50
    gpu 6
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 2
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 28
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
]

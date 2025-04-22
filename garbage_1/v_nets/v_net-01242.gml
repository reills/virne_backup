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
  id 1242
  arrival_time 25577.9046643183
  lifetime 1156.3503487681805
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 47
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 8
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 26
    rom 4
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 23
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 43
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 8
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 14
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 29
    rom 1
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 41
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 41
    rom 0
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 29
    rom 40
  ]
  node [
    id 11
    label "11"
    cpu 17
    gpu 13
    rom 4
  ]
  node [
    id 12
    label "12"
    cpu 29
    gpu 31
    rom 20
  ]
  node [
    id 13
    label "13"
    cpu 3
    gpu 9
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 28
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
  edge [
    source 10
    target 11
    bw 4
  ]
  edge [
    source 11
    target 12
    bw 30
  ]
  edge [
    source 12
    target 13
    bw 46
  ]
]

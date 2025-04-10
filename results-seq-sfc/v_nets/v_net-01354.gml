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
  id 1354
  arrival_time 28628.50276511444
  lifetime 1714.2759018973136
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 29
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 25
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 13
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 1
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 9
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 44
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 4
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 44
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 22
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 27
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 0
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 31
    gpu 50
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
]

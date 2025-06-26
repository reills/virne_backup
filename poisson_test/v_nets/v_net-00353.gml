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
  id 353
  arrival_time 6680.264444531597
  lifetime 1036.328998872642
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 35
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 15
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 40
    gpu 47
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 30
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 25
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 41
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 16
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 40
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 5
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 13
    rom 33
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 22
    rom 19
  ]
  node [
    id 11
    label "11"
    cpu 43
    gpu 26
    rom 22
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 24
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 1
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 43
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
  edge [
    source 11
    target 12
    bw 0
  ]
]

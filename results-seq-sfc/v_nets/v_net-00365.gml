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
  id 365
  arrival_time 6959.9853628676765
  lifetime 76.52055139272667
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 50
    gpu 37
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 7
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 16
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 43
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 5
    rom 36
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 42
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 43
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 50
    rom 24
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 42
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 30
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 35
    gpu 35
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 32
    rom 44
  ]
  node [
    id 12
    label "12"
    cpu 8
    gpu 40
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 48
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 26
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
]

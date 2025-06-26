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
  id 1089
  arrival_time 22775.546445844906
  lifetime 3062.9511188660713
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 26
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 35
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 3
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 25
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 21
    rom 30
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 12
    rom 3
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 23
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 5
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 18
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 31
    rom 40
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 49
    rom 7
  ]
  node [
    id 11
    label "11"
    cpu 38
    gpu 9
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 18
    gpu 38
    rom 37
  ]
  node [
    id 13
    label "13"
    cpu 28
    gpu 4
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 2
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
  edge [
    source 10
    target 11
    bw 38
  ]
  edge [
    source 11
    target 12
    bw 31
  ]
  edge [
    source 12
    target 13
    bw 29
  ]
]

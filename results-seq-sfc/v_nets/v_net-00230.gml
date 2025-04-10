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
  id 230
  arrival_time 4207.52944005154
  lifetime 1826.3439664809327
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 39
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 12
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 41
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 23
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 43
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 45
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 42
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 30
    rom 1
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 35
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 15
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 43
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 15
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 41
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
]

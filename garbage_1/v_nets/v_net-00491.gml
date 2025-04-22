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
  id 491
  arrival_time 9086.961738128104
  lifetime 1204.345933521995
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 8
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 34
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 35
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 4
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 33
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 20
    rom 9
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 30
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 18
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 1
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 12
    rom 50
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 33
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
]

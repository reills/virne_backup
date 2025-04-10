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
  id 144
  arrival_time 2558.9292327291123
  lifetime 2299.803738252961
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 24
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 16
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 32
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 37
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 6
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 11
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 44
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 2
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 12
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 10
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 40
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 15
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 8
  ]
]

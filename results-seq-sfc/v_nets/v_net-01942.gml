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
  id 1942
  arrival_time 42785.85099005212
  lifetime 639.6356899347592
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 0
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 49
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 33
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 20
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 38
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 8
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 31
    rom 21
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 30
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 30
    rom 45
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 5
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 30
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 35
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
]

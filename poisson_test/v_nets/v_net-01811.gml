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
  id 1811
  arrival_time 40193.87980215514
  lifetime 3752.9522044523405
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 1
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 33
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 45
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 32
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 21
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 19
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 5
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 17
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 36
    rom 21
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 8
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 22
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 27
    gpu 48
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
]

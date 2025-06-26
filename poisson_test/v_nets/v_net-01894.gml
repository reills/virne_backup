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
  id 1894
  arrival_time 41802.51054420881
  lifetime 364.7499073303251
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 23
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 24
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 39
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 17
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 5
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 22
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 45
    rom 44
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 14
    rom 9
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 0
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 18
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 10
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 12
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
]

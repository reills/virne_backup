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
  id 1323
  arrival_time 27665.27614097778
  lifetime 270.7396328204506
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 31
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 4
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 6
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 12
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 40
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 27
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 38
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 2
    gpu 22
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 27
    rom 36
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 38
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 31
    rom 33
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 31
    rom 12
  ]
  node [
    id 12
    label "12"
    cpu 49
    gpu 44
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 35
  ]
  edge [
    source 11
    target 12
    bw 17
  ]
]

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
  id 1159
  arrival_time 24088.8885861298
  lifetime 1944.8878888003806
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 38
    gpu 35
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 24
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 36
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 14
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 34
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 27
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 22
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 37
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 50
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 24
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 43
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 32
  ]
]

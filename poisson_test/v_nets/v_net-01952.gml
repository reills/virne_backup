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
  id 1952
  arrival_time 42831.696551157394
  lifetime 84.64019231588244
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 30
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 14
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 1
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 27
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 14
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 2
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 50
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 4
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 20
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 5
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 39
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 43
  ]
  edge [
    source 7
    target 8
    bw 38
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
]
